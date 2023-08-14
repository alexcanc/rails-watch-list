// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap";

import AOS from 'aos';
import 'aos/dist/aos.css'; // Import AOS styles

document.addEventListener('DOMContentLoaded', function() {
  AOS.init();
});
