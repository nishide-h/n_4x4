import Vue from 'vue/dist/vue.esm.js'
//import Router from './router/router'
import Status from './components/status.vue'

var app = new Vue({
 // router: Router,
  el: '#app',
  components: {
    'status_mode': Status
  }
});

const SHEET_STATUS = {
  ADD_TASK : 1,
  SELECT1 : 2,
  SELECT2 : 3,
  SELECT3 : 4,
  FINISH : 5
};

var store = {
  debug: true,
  state: {
    sheetStatus: SHEET_STATUS.ADD_TASK
  },
  setStatusAction(newValue) {
    if (this.debug) console.log("setStatusAction triggered with", newValue);
    this.state.sheetStatus = newValue;
  },
  getStatusAction() {
    if (this.debug) console.log("getStatusAction triggered");
    this.state.sheetStatus = SHEET_STATUS.ADD_TASK;
  }
};
