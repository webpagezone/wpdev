<?php
	/**
	 * Add a widget to the dashboard.
	 * This function is hooked into the 'wp_dashboard_setup' action below.
	 */
	function devwp_add_dashboard_widgets() {
		
		wp_add_dashboard_widget(
			'devwp_dashboard_widget', // Widget slug.
			'DevWP Theme Support', // Title.
			'devwp_dashboard_widget_function' // Display function.
		);
	}
	
	add_action( 'wp_dashboard_setup', 'devwp_add_dashboard_widgets' );
	
	/**
	 * Create the function to output the contents of our Dashboard Widget.
	 */
	function devwp_dashboard_widget_function() {
		?>
		<p>Checkout My other themes and services.
			<a href="<?php echo esc_url( __( 'https://www.pixemweb.com/premium-wordpress-themes/', 'devwp' ) ); ?>">
				<?php
					printf( esc_html__( 'Premium WordPress %s', 'devwp' ), 'Themes' );
				?>
			</a>
		</p>
		<p>Make sure to follow the video tutorial in order to get a detailed overview of how the code works.
			<a href="<?php echo esc_url( __( 'https://www.youtube.com/watch?v=pEJ2IzYOx5c&list=PL97Qo7C6CNAyQ8spj0Mp9tjI0q4j0ARzi', 'devwp' ) ); ?>">
				<?php
					printf( esc_html__( 'Follow The Video Tutorial for %s', 'devwp' ), 'DevWP' );
				?>
			</a>
		</p>
		<p>Checkout the various tutorials and articles I've written on
			<a href="<?php echo esc_url( __( 'https://www.pixemweb.com/blog/', 'devwp' ) ); ?>">
				<?php
					printf( esc_html__( '%s', 'devwp' ), 'PixemWeb' );
				?>
			</a>
		</p>
		<p>If you need any help feel free to contact me
			<a href="<?php echo esc_url( __( 'https://www.pixemweb.com/contact-us/', 'devwp' ) ); ?>">
				<?php
					printf( esc_html__( '%s', 'devwp' ), 'Contact' );
				?>
			</a>
		</p>
		<?php
		
	}