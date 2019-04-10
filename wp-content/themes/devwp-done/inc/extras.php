<?php

// The code below bypasses the front-page.php file when the the is_home() is true
// https://codex.wordpress.org/Creating_a_Static_Front_Page
	function devwp_filter_front_page_template( $template ) {
		return is_home() ? '' : $template;
	}

	add_filter( 'frontpage_template', 'devwp_filter_front_page_template' );

// Default template. Check the customizer.php file
	function devwp_default_post_template() {
		global $post;
		$devwp_sidebar_options = get_theme_mod( 'devwp_sidebar_options' );

		if ( 'post' == $post -> post_type &&
		     0 != count( get_page_templates( $post ) )
		     // && get_option( 'page_for_posts' ) != $post->ID // Not the page for listing posts
		     &&
		     'left' == $devwp_sidebar_options &&
		     '' == $post -> page_template // Only when page_template is not set
		) {
			$post -> page_template = "single_left_sb.php";

		} elseif ( 'post' == $post -> post_type &&
		           0 != count( get_page_templates( $post ) )
		           // && get_option( 'page_for_posts' ) != $post->ID // Not the page for listing posts
		           &&
		           'none' == $devwp_sidebar_options &&
		           '' == $post -> page_template // Only when page_template is not set
		) {
			$post -> page_template = "single_full_width.php";

		} elseif ( 'page' == $post -> post_type &&
		           0 != count( get_page_templates( $post ) ) &&
		           get_option( 'page_for_posts' ) != $post -> ID // Not the page for listing posts
		           &&
		           'left' == $devwp_sidebar_options &&
		           '' == $post -> page_template // Only when page_template is not set
		) {
			$post -> page_template = "page_left_sb.php";

		} elseif ( 'page' == $post -> post_type &&
		           0 != count( get_page_templates( $post ) ) &&
		           get_option( 'page_for_posts' ) != $post -> ID // Not the page for listing posts
		           &&
		           'none' == $devwp_sidebar_options &&
		           '' == $post -> page_template // Only when page_template is not set
		) {
			$post -> page_template = "page_full_width.php";
		}
	}

	add_action( 'add_meta_boxes', 'devwp_default_post_template', 1 );


//	Change The Admin Footer Text
	function devwp_remove_footer_admin() {
		?> <a
			href="<?php echo esc_url( __( 'https://www.pixemweb.com/devwp/', 'devwp' ) ); ?>"> <?php printf( esc_html__( 'DevWP Theme By: %s', 'devwp' ), 'PixemWeb' ); ?> </a>
		<?php
	}

	add_filter( 'admin_footer_text', 'devwp_remove_footer_admin' );


// Replaces the excerpt "Read More" text with a link
	function devwp_excerpt_more() {
		global $post;

		return '<a class="moretag" href="' . get_permalink( $post -> ID ) . '">Continue Reading</a>';
	}

	add_filter( 'excerpt_more', 'devwp_excerpt_more' );

	/**
	 * Excerpt length
	 */
	function devwp_excerpt_length() {
		$excerpt = get_theme_mod( 'exc_length', '40' );

		return absint( $excerpt );
	}

	add_filter( 'excerpt_length', 'devwp_excerpt_length', 99 );
