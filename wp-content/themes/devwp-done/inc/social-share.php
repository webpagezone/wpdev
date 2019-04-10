<?php
	
	function devwp_social_share_menu_item() {
		add_theme_page( "Social Share", "Social Share", "edit_theme_options", "social-share", "devwp_social_share_page" );
	}
	
	add_action( "admin_menu", "devwp_social_share_menu_item" );
	
	function devwp_social_share_page() {
		?>
		<div class="wrap">
			<h1>Social Sharing Options</h1>
			
			<form method="post" action="options.php">
				<?php
					settings_fields( "social_share_config_section" );
					do_settings_sections( "social-share" );
					submit_button();
				?>
			</form>
		</div>
		<?php
	}
	
	function devwp_social_share_settings() {
		add_settings_section( "social_share_config_section", "", null, "social-share" );
		
		add_settings_field( "social-share-reddit", "Do you want to display Reddit share button?", "social_share_reddit_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-facebook", "Do you want to display Facebook share button?", "social_share_facebook_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-twitter", "Do you want to display Twitter share button?", "social_share_twitter_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-linkedin", "Do you want to display LinkedIn share button?", "social_share_linkedin_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-flipboard", "Do you want to display Flipboard share button?", "social_share_flipboard_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-pinterest", "Do you want to display Pinterest share button?", "social_share_pinterest_checkbox", "social-share", "social_share_config_section" );
		
		add_settings_field( "social-share-digg", "Do you want to display Digg share button?", "social_share_digg_checkbox", "social-share", "social_share_config_section" );
		
		
		register_setting( "social_share_config_section", "social-share-reddit" );
		register_setting( "social_share_config_section", "social-share-facebook" );
		register_setting( "social_share_config_section", "social-share-twitter" );
		register_setting( "social_share_config_section", "social-share-linkedin" );
		register_setting( "social_share_config_section", "social-share-flipboard" );
		register_setting( "social_share_config_section", "social-share-pinterest" );
		register_setting( "social_share_config_section", "social-share-digg" );
	}
	
	function social_share_reddit_checkbox() {
		?>
		<input type="checkbox" name="social-share-reddit"
		       value="1" <?php checked( 1, get_option( 'social-share-reddit' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_facebook_checkbox() {
		?>
		<input type="checkbox" name="social-share-facebook"
		       value="1" <?php checked( 1, get_option( 'social-share-facebook' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_twitter_checkbox() {
		?>
		<input type="checkbox" name="social-share-twitter"
		       value="1" <?php checked( 1, get_option( 'social-share-twitter' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_linkedin_checkbox() {
		?>
		<input type="checkbox" name="social-share-linkedin"
		       value="1" <?php checked( 1, get_option( 'social-share-linkedin' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_flipboard_checkbox() {
		?>
		<input type="checkbox" name="social-share-flipboard"
		       value="1" <?php checked( 1, get_option( 'social-share-flipboard' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_pinterest_checkbox() {
		?>
		<input type="checkbox" name="social-share-pinterest"
		       value="1" <?php checked( 1, get_option( 'social-share-pinterest' ), true ); ?> /> Check for Yes
		<?php
	}
	
	function social_share_digg_checkbox() {
		?>
		<input type="checkbox" name="social-share-digg"
		       value="1" <?php checked( 1, get_option( 'social-share-digg' ), true ); ?> /> Check for Yes
		<?php
	}
	
	add_action( "admin_init", "devwp_social_share_settings" );
	
	
	function devwp_add_social_share_icons( $content ) {
		if ( is_archive() || is_home() || is_search() || is_front_page() ) {
			return $content;
		} elseif ( is_singular() && is_main_query() ) {
			$html = '';
			if ( get_option( "social-share-reddit" ) || get_option( "social-share-facebook" ) || get_option( "social-share-twitter" ) || get_option( "social-share-linkedin" ) || get_option( "social-share-flipboard" ) || get_option( "social-share-pinterest" ) || get_option( "social-share-digg" ) ) {
				$html = "<h4 class='share-title'>Share This On:</h4>";
				$html = $html . "<div class='social-share-wrapper'><div class='share-on'>";
				
			}
			// $html = $html . "<div class='social-share-wrapper'><div class='share-on'>";
			
			
			global $post;
			
			$url         = get_permalink( $post->ID );
			$url         = esc_url( $url );
			$title       = get_the_title();
			$title       = esc_url( $title );
			$description = get_bloginfo( 'description' );
			
			// http://www.sharelinkgenerator.com/
			
			if ( get_option( "social-share-reddit" ) == 1 ) {
				$html = $html . "<div class='reddit menu-social'><ul><li><a target='_blank' href='https://reddit.com/submit?url=" . $url . "&title=" . $title . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-facebook" ) == 1 ) {
				$html = $html . "<div class='facebook menu-social'><ul><li><a target='_blank' href='https://www.facebook.com/sharer.php?u=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-twitter" ) == 1 ) {
				$html = $html . "<div class='twitter menu-social'><ul><li><a target='_blank' href='https://twitter.com/share?url=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-linkedin" ) == 1 ) {
				$html = $html . "<div class='linkedin menu-social'><ul><li><a target='_blank' href='https://www.linkedin.com/shareArticle?url=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-flipboard" ) == 1 ) {
				$html = $html . "<div class='flipboard menu-social'><ul><li><a target='_blank' href='https://share.flipboard.com/bookmarklet/popout?v=2&" . $title . "&url=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-pinterest" ) == 1 ) {
				$html = $html . "<div class='pinterest menu-social'><ul><li><a target='_blank' href='https://pinterest.com/pin/create/button/?url=&media=&description=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-digg" ) == 1 ) {
				$html = $html . "<div class='digg menu-social'><ul><li><a target='_blank' href='https://digg.com/submit?url=" . $url . "'></a></li></ul></div>";
			}
			
			if ( get_option( "social-share-reddit" ) || get_option( "social-share-facebook" ) || get_option( "social-share-twitter" ) || get_option( "social-share-linkedin" ) || get_option( "social-share-flipboard" ) || get_option( "social-share-google" ) || get_option( "social-share-pinterest" ) || get_option( "social-share-digg" ) ) {
				$html = $html . "</div> </div>";
			}
		}
		
		return $content = $content . $html;
	}
	
	add_filter( "the_content", "devwp_add_social_share_icons" );
	
	
	/**
	 * Social Media Menu
	 */
	function devwp_social_menu() {
		if ( has_nav_menu( 'social' ) ) {
			?>
			<h2>Connect With Us</h2>
			<?php
			wp_nav_menu(
				array(
					'theme_location'  => 'social',
					'container'       => 'div',
					'container_id'    => 'menu-social',
					'container_class' => 'menu-social',
					'menu_id'         => 'menu-social-items',
					'menu_class'      => 'menu-items',
					'depth'           => 1,
					'link_before'     => '<span class="screen-reader-text">',
					'link_after'      => '</span>',
					'fallback_cb'     => '',
				)
			);
		}
	}

