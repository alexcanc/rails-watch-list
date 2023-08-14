import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const rating = parseFloat(this.data.get("rating")); // Parse the rating as a float
    this.element.style.setProperty("--rating", rating);
  }
}
