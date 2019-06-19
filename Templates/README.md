### Install

To install the Xcode templates, run the `Makefile` via:

	make install_templates

To use a template go to "File" → "New" → "File...". Scroll down to "Custom Templates" and select one.

This will create all the files of a scene, but without groups. So you certainly want to clean up this by creating the necessary sub-folders. Also make sure all created files are added properly to their targets.

### Uninstall

To uninstall the Xcode templates, run:

	make uninstall_templates

Or simply delete the installed files manually from:

	~/Library/Developer/Xcode/Templates/File Templates/

### More

For more information about Xcode templates see:

- [https://medium.com/itch-design-no/creating-your-own-templates-in-xcode-98a08bf20038](https://medium.com/itch-design-no/creating-your-own-templates-in-xcode-98a08bf20038)
- [http://jeanetienne.net/2017/08/27/xcode-template.html](http://jeanetienne.net/2017/08/27/xcode-template.html)
- [http://jeanetienne.net/2017/09/10/advanced-xcode-template.html](http://jeanetienne.net/2017/09/10/advanced-xcode-template.html)