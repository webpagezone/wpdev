<?php
	/**
	 * DevWP functions and definitions
	 *
	 * @link    https://developer.wordpress.org/themes/basics/theme-functions/
	 *
	 * @package DevWP
	 * @since   1.0
	 */

	if ( ! function_exists( 'devwp_setup' ) ):
		/**
		 * Sets up theme defaults and registers support for various WordPress features.
		 *
		 * Note that this function is hooked into the after_setup_theme hook, which
		 * runs before the init hook. The init hook is too late for some features, such
		 * as indicating support for post thumbnails.
		 */
		function devwp_setup() {
			/*
			 * Make theme available for translation.
			 * Translations can be filed in the /languages/ directory.
			 * If you're building a theme based on DevWP, use a find and replace
			 * to change 'devwp' to the name of your theme in all the template files.
			 */
			load_theme_textdomain( 'devwp', get_template_directory() . '/languages' );

			// Add default posts and comments RSS feed links to head.
			add_theme_support( 'automatic-feed-links' );

			/*
			 * Let WordPress manage the document title.
			 * By adding theme support, we declare that this theme does not use a
			 * hard-coded <title> tag in the document head, and expect WordPress to
			 * provide it for us.
			 */
			add_theme_support( 'title-tag' );

			/*
			 * Enable support for Post Thumbnails on posts and pages.
			 *
			 * @link https://developer.wordpress.org/themes/functionality/featured-images-post-thumbnails/
			 */
			add_theme_support( 'post-thumbnails' );
			add_image_size( 'large-thumb', 1140, 641, true );
			add_image_size( 'xl-thumb', 2560, 1440, true );


			// This theme uses wp_nav_menu() in two locations.
			register_nav_menus( array(
				'primary' => esc_html__( 'Primary', 'devwp' ),
				'social'  => esc_html__( 'Social Menu', 'devwp' ),
			) );

			/*
			 * Switch default core markup for search form, comment form, and comments
			 * to output valid HTML5.
			 */
			add_theme_support( 'html5', array(
				'search-form',
				'comment-form',
				'comment-list',
				'gallery',
				'caption',
			) );

			// Set up the WordPress core custom background feature.
			add_theme_support( 'custom-background', apply_filters( 'devwp_custom_background_args', array(
				'default-color' => 'ffffff',
				'default-image' => '',
			) ) );

			// Add theme support for selective refresh for widgets.
			add_theme_support( 'customize-selective-refresh-widgets' );

			// https://wordpress.org/gutenberg/handbook/designers-developers/developers/themes/theme-support/
			// Load regular editor styles into the new block-based editor.
			add_theme_support( 'editor-styles' );
			// Enqueue editor styles.
			function devwp_add_editor_style() {
				add_editor_style( 'dist/editor-style.css' );
			}

			add_action( 'admin_init', 'devwp_add_editor_style' );

			// Add support for Block Styles.
			add_theme_support( 'wp-block-styles' );

			// Add support for full and wide align images.
			add_theme_support( 'align-wide' );

			// Add support for responsive embedded content.
			add_theme_support( 'responsive-embeds' );

			/**
			 * Add support for core custom logo.
			 *
			 * @link https://codex.wordpress.org/Theme_Logo
			 */
			add_theme_support( 'custom-logo', array(
				'height'      => 250,
				'width'       => 250,
				'flex-width'  => true,
				'flex-height' => true,
			) );

			// Just in case you want to use excerpts on a page
			add_post_type_support( 'page', 'excerpt' );

			// Container width.
			$devwp_container_type = get_theme_mod( 'devwp_container_type' );
			if ( '' == $devwp_container_type ) {
				set_theme_mod( 'devwp_container_type', 'container' );
			}

			$devwp_sidebar_options = get_theme_mod( 'devwp_sidebar_options' );
			if ( '' == $devwp_sidebar_options ) {
				set_theme_mod( 'devwp_sidebar_options', 'right' );
			}
		}
	endif;
	add_action( 'after_setup_theme', 'devwp_setup' );


	/**
	 * Set the content width in pixels, based on the theme's design and stylesheet.
	 *
	 * Priority 0 to make it available to lower priority callbacks.
	 *
	 * @global int $content_width
	 */
	function devwp_content_width() {
		// This variable is intended to be overruled from themes.
		// Open WPCS issue: {@link https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/issues/1043}.
		// phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals.NonPrefixedVariableFound
		$content_width              = 1920;
		$GLOBALS[ 'content_width' ] = apply_filters( 'devwp_content_width', $content_width );
	}

	add_action( 'after_setup_theme', 'devwp_content_width', 0 );


/**
 * Enqueue scripts and styles.
 */

// 	if ( ! is_admin() ) {
// 		function devwp_local_jquery() {
// 			wp_deregister_script( 'jquery' );
// 			wp_register_script( 'jquery', get_theme_file_uri( '/dist/js/jquery-3.3.1.js' ), array(), '3.3.1' );
// 			// wp_add_inline_script( 'jquery3.3.1', 'var jQuery3_3_1 = $.noConflict(true);' );
// 			wp_enqueue_script( 'jquery' );
// 		}
//
// 		add_action( 'wp_enqueue_scripts', 'devwp_local_jquery' );
// 	}
//
// //Remove JQuery migrate
// 	function devwp_remove_jquery_migrate( $scripts ) {
// 		if ( ! is_admin() && isset( $scripts->registered[ 'jquery' ] ) ) {
// 			$script = $scripts->registered[ 'jquery' ];
//
// 			if ( $script->deps ) { // Check whether the script has any dependencies
// 				$script->deps = array_diff( $script->deps, array( 'jquery-migrate' ) );
// 			}
// 		}
// 	}
//
// 	add_action( 'wp_default_scripts', 'devwp_remove_jquery_migrate' );

	/**
	 * Register custom fonts.
	 */
	function dev_fonts_url() {
		$fonts_url = '';

		/*
		 * Translators: If there are characters in your language that are not
		 * supported by Hind, translate this to 'off'. Do not translate
		 * into your own language.
		 */
		$hind = _x( 'on', 'Hind font: on or off', 'devwp' );

		if ( 'off' !== $hind ) {
			$font_families = array();

			$font_families[] = 'Hind:400,600';

			$query_args = array(
				'family' => urlencode( implode( '|', $font_families ) ),
				'subset' => urlencode( 'latin,latin-ext' ),
			);

			$fonts_url = add_query_arg( $query_args, 'https://fonts.googleapis.com/css' );
		}

		return esc_url_raw( $fonts_url );
	}

	/**
	 * Add preconnect for Google Fonts.
	 *
	 * @param array  $urls          URLs to print for resource hints.
	 * @param string $relation_type The relation type the URLs are printed.
	 *
	 * @return array $urls           URLs to print for resource hints.
	 * @since DevWP 1.0
	 *
	 */
	function dev_resource_hints( $urls, $relation_type ) {
		if ( wp_style_is( 'dev-fonts', 'queue' ) && 'preconnect' === $relation_type ) {
			$urls[] = array(
				'href' => 'https://fonts.gstatic.com',
				'crossorigin',
			);
		}

		return $urls;
	}

	add_filter( 'wp_resource_hints', 'dev_resource_hints', 10, 2 );

	function devwp_scripts() {
		wp_enqueue_style( 'dev-fonts', dev_fonts_url(), array(), null );

		wp_enqueue_style( 'devwp-style-min', get_theme_file_uri() . '/style.css' );

		wp_enqueue_script( 'devwp-js', get_theme_file_uri( '/dist/js/devwp.js' ), array( 'jquery' ), '1.0.6', true );

		if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
			wp_enqueue_script( 'comment-reply' );
		}
	}

	add_action( 'wp_enqueue_scripts', 'devwp_scripts' );

	/**
	 * Enqueue supplemental block editor styles.
	 */
	function devwp_editor_styles() {

		// wp_enqueue_style( 'devwp-block-editor-styles', get_theme_file_uri( '/dist/editor-styles.css' ), false, '1.1', 'all' );
		wp_enqueue_style( 'devwp-block-editor-fonts', 'https://fonts.googleapis.com/css?family=Hind:400,600' );


	}

	add_action( 'enqueue_block_editor_assets', 'devwp_block-editor_styles' );

	/**
	 * Implement the Custom Header feature.
	 */
	require get_parent_theme_file_path( '/inc/custom-header.php' );


	/**
	 * Custom template tags for this theme.
	 */
	require get_parent_theme_file_path( '/inc/template-tags.php' );

	/**
	 * Functions which enhance the theme by hooking into WordPress.
	 */
	require get_parent_theme_file_path( '/inc/template-functions.php' );

	/**
	 * Customizer additions.
	 */
	require get_parent_theme_file_path( '/inc/customizer.php' );

	/**
	 * Code Embed.
	 */
	if ( ! has_blocks() ) {

	require get_parent_theme_file_path( '/inc/code-embed.php' );
	}

	/**
	 * Media File.
	 */
	require get_parent_theme_file_path( '/inc/media.php' );

	/**
	 * Extras File.
	 */
	require get_parent_theme_file_path( '/inc/extras.php' );

	/**
	 * Optimizations File.
	 */
	require get_parent_theme_file_path( '/inc/optimizations.php' );

	/**
	 * Widgets File.
	 */
	require get_parent_theme_file_path( '/inc/widgets.php' );

	/**
	 * Bootstrap Navwalker File.
	 */
	require get_parent_theme_file_path( '/inc/bootstrap-wp-navwalker.php' );

	/**
	 * Dashboard Widgets Functionality.
	 */
	require get_parent_theme_file_path( '/inc/dashboard-widgets.php' );

	/**
	 * Shortcodes file.
	 */
	require get_parent_theme_file_path( '/inc/shortcodes.php' );

	/**
	 * Social Connection Code
	 */
	require get_parent_theme_file_path( '/inc/social-share.php' );

	/**
	 * Load Jetpack compatibility file.
	 */
	if ( defined( 'JETPACK__VERSION' ) ) {
		require get_parent_theme_file_path( '/inc/jetpack.php' );
	}

	/**
	 * Load WooCommerce compatibility file.
	 */
	if ( class_exists( 'WooCommerce' ) ) {
		require get_parent_theme_file_path( '/inc/woocommerce.php' );
	}

// 	function my_function_admin_bar() {
//   return false;
// }

// add_filter( 'show_admin_bar' , 'my_function_admin_bar');

// Remove the code below for the production version. This is only to remove the error when in debug mode and only for Windows.
//  https://wordpress.org/support/topic/notice-ob_end_flush-failed-to-send-buffer-of-zlib-output-compression/
	// remove_action( 'shutdown', 'wp_ob_end_flush_all', 1 );
