import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Helloooooo");
    this.element.textContent = "Hello World!"
  }
}
