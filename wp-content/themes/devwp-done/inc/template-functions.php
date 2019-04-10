<?php
	/**
	 * Functions which enhance the theme by hooking into WordPress
	 *
	 * @package DevWP
	 */

	/**
	 * Adds custom classes to the array of body classes.
	 *
	 * @param array $classes Classes for the body element.
	 *
	 * @return array
	 */
	function devwp_body_classes( $classes ) {
		// Adds a class of hfeed to non-singular pages.
		if ( ! is_singular() ) {
			$classes[] = 'hfeed';
		}

		return $classes;
	}

	add_filter( 'body_class', 'devwp_body_classes' );

	/**
	 * Add a pingback url auto-discovery header for singularly identifiable articles.
	 */
	function devwp_pingback_header() {
		if ( is_singular() && pings_open() ) {
			echo '<link rel="pingback" href="', esc_url( get_bloginfo( 'pingback_url' ) ), '">';
		}
	}

	add_action( 'wp_head', 'devwp_pingback_header' );


// Display Post, Page and Media ID's in Columns
	add_filter( 'manage_posts_columns', 'devwp_show_id_column', 5 );
	add_action( 'manage_posts_custom_column', 'devwp_showid_id_column_content', 5, 2 );
	add_filter( 'manage_pages_columns', 'devwp_show_id_column', 5 );
	add_action( 'manage_pages_custom_column', 'devwp_showid_id_column_content', 5, 2 );
	add_filter( 'manage_media_columns', 'devwp_show_id_column', 5 );
	add_action( 'manage_media_custom_column', 'devwp_showid_id_column_content', 5, 2 );


	function devwp_show_id_column( $columns ) {
		$columns[ 'showid_id' ] = 'ID';

		return $columns;
	}

	function devwp_showid_id_column_content( $column, $id ) {
		if ( 'showid_id' == $column ) {
			echo $id;
		}
	}

// Display the User's ID's in Columns
	add_filter( 'manage_users_columns', 'devwp_show_user_column' );
	add_action( 'manage_users_custom_column', 'devwp_show_user_id_column_content', 10, 3 );

	function devwp_show_user_column( $columns ) {
		$columns[ 'user_id' ] = 'ID';

		return $columns;
	}

	function devwp_show_user_id_column_content( $value, $column_name, $user_id ) {
		if ( 'user_id' == $column_name ) {
			return $user_id;
		}
		return $value;
	}

	/**
	 * Header image check
	 */
	// Functions to work with:
	//  https://developer.wordpress.org/reference/functions/get_custom_header_markup/
	//  https://developer.wordpress.org/reference/functions/the_custom_header_markup/
	//  https://codex.wordpress.org/Function_Reference/get_theme_mod
	//  https://developer.wordpress.org/reference/functions/get_header_image/
	//  https://codex.wordpress.org/get_header_image
	//  https://developer.wordpress.org/reference/functions/has_header_image/
	//  https://developer.wordpress.org/reference/functions/has_header_video/

	function devwp_has_header() {
		if ( get_header_image() ) {
			return 'has-header';
		}
		return '';
	}

	/**
	 * Header text
	 */
	function devwp_header_text() {
		$header_text       = get_theme_mod( 'header_text' );
		$header_subtext    = get_theme_mod( 'header_subtext' );
		$header_button     = get_theme_mod( 'header_button' );
		$header_button_url = get_theme_mod( 'header_button_url' );

		echo '<div class="header-info row no-gutters">
						<div class="col-12 text-center">
						<p class="h4 mb-0 header-subtext">' . wp_kses_post( $header_subtext ) . '</p>
						<p class="h3 mb-3 header-text">' . wp_kses_post( $header_text ) . '</p>';
		if ( $header_button_url ) {
			echo '<a class="button header-button" href="' . esc_url( $header_button_url ) . '">' . esc_html( $header_button ) . '</a>';
		}
		echo '</div></div>';
	}

	function devwp_header_blog() {
		$header_blog                = get_theme_mod( 'header_blog' );
		$header_blog_secondary_text = get_theme_mod( 'header_blog_secondary_text' );
		$header_blog_button         = get_theme_mod( 'header_blog_button' );
		$header_blog_button_url     = get_theme_mod( 'header_blog_button_url' );

		echo '<div class="header-info row no-gutters">
		<div class="col-12 text-center">
				<p class="h4 mb-0 header-subtext">' . wp_kses_post( $header_blog_secondary_text ) . '</p>
				<p class="h3 mb-3 header-text">' . wp_kses_post( $header_blog ) . '</p>';
		if ( $header_blog_button_url ) {
			echo '<a class="button header-button" href="' . esc_url( $header_blog_button_url ) . '">' . esc_html( $header_blog_button ) . '</a>';
		}
		echo '</div></div>';
	}
