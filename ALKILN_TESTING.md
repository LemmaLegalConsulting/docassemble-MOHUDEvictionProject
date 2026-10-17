The full fixture follows eviction_motion_to_continue.yml to its actual download page and preserves the existing startup scenarios.

Confirmed source blocker: this entry references eviction_motion_to_continue_next_steps.docx and eviction_motion_to_continue.docx, neither of which is present in data/templates. Docassemble fails while loading the YAML, before any fixture input can be entered. Existing main-interview templates have a different variable contract, so copying or substituting them would need document-generation and legal-content review. Supply the missing templates or retire/repair this entry with maintainer review; the fixture does not hide the failure.

The isolated workflow is active, has declared include dependencies and failure diagnostics, and this PR remains draft pending repair of the interview source.
