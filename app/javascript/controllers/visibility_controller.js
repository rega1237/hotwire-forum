import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "content" ]

  toggle() {
    console.log('toggle 3')
    this.contentTarget.hidden = !this.contentTarget.hidden
  }
}
