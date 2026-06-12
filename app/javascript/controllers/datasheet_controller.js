import { Controller } from "@hotwired/stimulus"

// Fills the datasheet field with a suggested link when its "Use" button is clicked.
export default class extends Controller {
  static targets = ["field"]

  use(event) {
    if (this.hasFieldTarget) {
      this.fieldTarget.value = event.params.link
    }
  }
}
