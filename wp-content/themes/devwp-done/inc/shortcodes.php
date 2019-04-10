<?php
// Show Active Shortcodes in The Appearance Section of the Admin Dashboard
	if ( is_admin() ) {
		$shortcodes = new View_Active_Shortcodes();
	}

	class View_Active_Shortcodes {
		public
		function __construct() {
			$this->Admin();
		}

		/**
		 * Create the admin area
		 */
		public
		function Admin() {
			add_action( 'admin_menu', array( & $this, 'Admin_Menu' ) );
		}

		/**
		 * Function for the admin menu to create a menu item in the Appearance Section
		 */
		public
		function Admin_Menu() {
			add_theme_page(
				'View Active Shortcodes',
				'View Active Shortcodes',
				'edit_theme_options',
				'view-active-shortcodes',
				array( & $this, 'Show_Admin_Page' )
			);
		}

		/**
		 * Show the admin page
		 */
		public
		function Show_Admin_Page() {
			global $shortcode_tags;
			// https://codex.wordpress.org/User:Wycks/Styling_Option_Pages
			?>
			<div class="wrap">
				<div id="icon-tools" class="icon32">
					<br>
				</div>
				<h2>View Active Shortcodes</h2>
				<div class="section panel">
					<p>
						This page display's all active shortcodes that you can use on your website.
					</p>
					<table class="widefat importers">
						<tr>
							<td>
								<strong>Available Shortcodes - These come from the WordPress Core and Active Plugins</strong>
							</td>
						</tr>
						<?php foreach ( $shortcode_tags as $code => $function ) { ?>
							<tr>
								<td>
									[
									<?php echo $code; ?>]
								</td>
							</tr>
						<?php } ?>
					</table>
				</div>
			</div>
			<?php
		}
	} // END View_Active_Shortcodes class


// Enable shortcodes in text widgets
	add_filter( 'widget_text', 'shortcode_unautop' );
	add_filter( 'widget_text', 'do_shortcode' );
