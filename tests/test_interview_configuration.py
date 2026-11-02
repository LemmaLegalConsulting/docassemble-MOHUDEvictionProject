"""Regression checks for interview configuration, independent of a live server."""
from pathlib import Path
from ruamel.yaml import YAML

ROOT = Path(__file__).resolve().parents[1]
QUESTIONS = ROOT / "docassemble/MOHUDEvictionProject/data/questions"


def blocks(name):
    return list(YAML(typ="safe").load_all((QUESTIONS / name).read_text()))


def test_question_ids_are_present_and_unique_per_file():
    for path in QUESTIONS.glob("*.yml"):
        ids = []
        for block in blocks(path.name):
            if not isinstance(block, dict):
                continue
            if "question" in block:
                assert block.get("id"), path.name
            if "id" in block:
                ids.append(block["id"])
        assert len(ids) == len(set(ids)), path.name


def test_cross_screen_conditions_are_evaluated_server_side():
    intake = next(b for b in blocks("intake.yml") if b and b.get("id") == "county fallback")
    assert intake["fields"][0]["show if"] == {"code": 'address_type == "pick_county"'}
    trial = next(b for b in blocks("file_a_motion.yml") if b and b.get("only sets") == "trial_date")
    assert trial["fields"][0]["show if"] == {"code": "trial_date_set"}
    lease = next(b for b in blocks("defense_logic.yml") if b and b.get("id") == "petition requirements - terms of lease")
    note = lease["fields"][0]
    assert "js show if" not in note
    assert note["show if"]["code"].strip() == "has_written_lease == False or lease_attached == False"


def test_southern_missouri_referrals_are_not_concatenated():
    county_block = next(b for b in blocks("court_information.yml") if b and b.get("variable name") == "county_dictionary")
    for county in ("Ste. Genevieve County", "St. Francois County"):
        referral = county_block["data"][county]
        assert referral["legal_aid_program"].strip() == "Legal Services of Southern Missouri"
        assert referral["legal_aid_program_website"].strip() == "https://www.lsosm.org/"
        assert referral["legal_aid_program_online_app"].strip() == "https://application.lsosm.org/"
        assert referral["legal_aid_program_phone_app"].strip() == "1-800-444-4863"
        assert "Sikeston" in referral["legal_aid_program_office_app_addresses"]


def test_docassemble_uses_native_namespace_packaging():
    # A legacy pkg_resources initializer breaks the whole server on setuptools 82+.
    assert not (ROOT / "docassemble/__init__.py").exists()
