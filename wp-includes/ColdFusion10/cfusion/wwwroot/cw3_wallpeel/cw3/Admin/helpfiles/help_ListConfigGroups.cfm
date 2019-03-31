<h2>Configuration Groups  Help</h2>
<p> The Configuration Group page lists the different Config groups that are part of Cartweaver. With the  config tables in the Cartweaver database, you can simply add groups or items to the standard Cartweaver   config
  tables. The options would then magically appear in the admin, and   resetting
  the application would provide all of those values in the   Application scope 
  for the site. The developer can then access the config information   from the 
  Application scope instead of relying on local variables   in 
  CWTagGlobalSettings, your static config file, or wherever else you may   have normally created a configuration value. Examples of possible developer-defined configuration groups might be for Display Colors, Access Levels, Customer Preferences, etc.</p>
<p>To add a new Config Group, type a name, a sort level, and whether or not to show the merchant. If you choose not to show to the merchant, the Config Group will be accessible only to the developer, such as the Debug Settings group that ships with Cartweaver. </p>
<p>Drilling down from Config Groups, the Config Items page allows you to set the various database-driven configuration items that are part of Cartweaver. In order to show the Configuration Items page, you must have the development Debug password, as set in the Application.cfm file. You reach the config.cfm page by adding ?debug=yourpassword to the URL while in the admin. The Config Groups link will appear in the navigation menu and you will have access to adjust the configuration. New configuration items can also be added to aid in your development. Each configuration item has it's own help icon for more information, but the following gives you a brief overview of the items that are available:</p>
<h3>Company Info</h3>
<p>Company info contains information about the company that will appear in the footer in a Cartweaver site, and is also used for confirmation emails and other instances where the company name, address, or email address are used in the site. More information on Company Info can be found <a href="AdminHelp.cfm?HelpFileName=CompanyInfo.cfm">here</a>. </p>
<h3>Debug Settings</h3>
<p>Debug settings allow you to view variables used on each page or in the site during development or during debugging. This is entirely independant of any ColdFusion debugging that is available on the server. You can choose to enable or disable debugging and choose which variables you want to display. Variable dumps are displayed at the bottom of the page if debugging is turned on. </p>
<h3>Discount Settings</h3>
<p>The discount settings allow you to enable or disable discounts in the store, and also allow you to display a separate item in the cart for discount, and to show the discount descriptions if available. Discounts are further explained <a href="AdminHelp.cfm?HelpFileName=DiscountDetails.cfm">here</a>. </p>
<h3>Display Settings</h3>
<p>Display settings encompass configuration items that show or hide aspects of the pages in the store. You can choose to show your results pages using multiple columns or single items on a page, how many items to display, and whether or not to show small images in the shopping cart. There is also an item that allows you to display a popup image on the Details page. If used, popup images must be uploaded using the administration section. Categories/Secondary categories can also be related using the configuration item &quot;Relate Categories/Secondaries&quot;. When this is checked, dropdown lists showing categories and secondaries become related based on products that are associated with the categories. </p>
<h3>Misc. Settings</h3>
<p>Anything that doesn't fit into one of the config groups goes here. The Cartweaver version number is also stored here. This can aid the developer when contacting the Cartweaver team for support. </p>
<h3>Shipping Settings</h3>
<p>Shipping can be charged based on weight or cost, and can be enabled here. Also, you can choose to charge a base rate and an amount based on location. The actual shipping costs are entered using the separate Shipping menu item. More detailed information on shipping settings can be found <a href="AdminHelp.cfm?HelpFileName=ShipSettings.cfm">here</a>. </p>
<h3>Tax Settings </h3>
<p>Settings related to tax are shown here, such as the ability to store and display a Tax ID number, show separate tax amounts in line items in the cart, and whether or not to charge tax on shipping. Taxes are more fully explained <a href="AdminHelp.cfm?HelpFileName=ListTaxRegions.cfm">here</a>. </p>
