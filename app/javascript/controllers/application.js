import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import NotificationController from "./notifications_controller"
application.register("notifications", NotificationController)

import VisibilityController from "./visibility_controller"
application.register("visibility", VisibilityController)

export { application }
