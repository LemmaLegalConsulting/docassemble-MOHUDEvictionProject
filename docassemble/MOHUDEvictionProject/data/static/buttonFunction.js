console.clear();


const trigger = document.querySelector('.js-trigger');
const panel = document.querySelector('.js-panel');
const panelInner = document.querySelector('.js-panel__inner');
const panelContent = document.querySelectorAll('.panel-content');

// This is the CSS Custom Property that is updated with the panel's content's height
const maxHeightKey = '--panel-max-height';

let state = {
  triggerExpanded: 'collapsed'
}


// Sets the relevant aria role based on its current value. Sets it to false by default
// if no value is set
const setTriggerState = () => {
  let currentExpandedState = trigger.getAttribute('aria-expanded');
    
  // If it's not set yet, set it to true so it is reversed below
  if(currentExpandedState === null) {
    currentExpandedState = 'true';
  }
  
  // Update our global state so other functions know what's up
  state.triggerExpanded = currentExpandedState === 'true' ? 'false' : 'true'
  
  trigger.setAttribute('aria-expanded', state.triggerExpanded);
  trigger.removeAttribute('hidden');
};

// Looks for content within the panel and calculates its height. This makes the transition smoother.
// Returns a promise so it can do its job before the toggle starts
const setMaxHeight = () => {
  
  return new Promise((resolve, reject) => {
    if(!panel || !panelInner) {
      reject();
    }  

    panel.style.setProperty(maxHeightKey, `${panelInner.getBoundingClientRect().height}px`);
    resolve();
  });
};

const run = () => {
  setMaxHeight()
  .then(() => setTriggerState());
};

trigger.addEventListener('click', run);

run();

trigger.forEach(link => {
  link.addEventListener('click', () => {
    const linkType = link.getAttribute('data-link');
    const content = document.querySelector(`.panel-content[data-link="${linkType}"]`);

    content.classList.toggle('active');
  });
});