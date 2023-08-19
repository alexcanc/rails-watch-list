console.log("File is loaded!");

import { Controller } from "stimulus";

import Typed from "typed.js";

export default class extends Controller {
  connect() {
    console.log("Typed Controller Connected!");
    new Typed(this.element, {
      strings: ["Welcome to My Lists", "Find Your Favorites", "Start Your Collection"],
      typeSpeed: 50, // typing speed
      backSpeed: 25, // backspacing speed
      backDelay: 1000, // delay before starting the backspacing
      startDelay: 1000, // start delay time in milliseconds
      loop: true, // loop strings
      showCursor: true // show cursor
      // ... and any other options you want
    });
  }
}
