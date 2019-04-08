import MessageUI

/**
 A mail controller to encapsulate the MessageUI framework.
 Manages opening the email UI and dismissing it, just keep a reference to this object.
 */
class MailController: NSObject {
	/**
	 Creates a new mail controller for sending an email to a specific recipient, e.g. for asking support.

	 - parameter emailAddress: The recipient's address.
	 - returns: The mail controller to present.
	 */
	func createMail(emailAddress: String) -> UIViewController? {
		guard MFMailComposeViewController.canSendMail() else {
			return nil
		}

		// Prepare email.
		let mail = MFMailComposeViewController()
		mail.mailComposeDelegate = self
		mail.setToRecipients([emailAddress])
		return mail
	}

	/**
	 Creates a new mail controller for sending an attachment, e.g. a backup file.

	 - parameter data: The data to add as an attachment.
	 - parameter mimeType: The data's mime type.
	 - parameter fileName: The name how the attachment should be named.
	 - returns: The mail controller to present.
	 */
	func createMail(attachment data: Data, mimeType: String, fileName: String) -> UIViewController? {
		guard MFMailComposeViewController.canSendMail() else {
			return nil
		}

		// Prepare email.
		let mail = MFMailComposeViewController()
		mail.mailComposeDelegate = self
		mail.addAttachmentData(data, mimeType: mimeType, fileName: fileName)
		return mail
	}
}

// MARK: - MFMailComposeViewControllerDelegate

extension MailController: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true)
	}
}
