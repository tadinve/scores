module ApplicationHelper

	def beautify_params key, value = nil, key_width = 200, opts = {}
		if value
			contents = content_tag(
					'b', key, :class => "fl #{opts[:key_class]}", :style => "width:#{key_width}px; #{opts[:key_style]}"
				) + content_tag(
					'div', value, :class => "light_text #{opts[:value_class]}", :style => "margin-left:#{key_width+10}px;  #{opts[:value_style]}"
				)
			
			return content_tag( 
				'div', contents, :class => 'beautify_params'
			)
		end
	end

	def image_radius size = 5
		"-webkit-border-radius: #{size}px; -moz-border-radius: #{size}px; border-radius: #{size}px;"
	end

	def link_user user = nil, opts = {}
		if user
			link_to user.name, user_path(user.id), opts
		end
	end

	def user_image user, size = nil, opts = {}
		if user
			get_width = opts[:width].presence ? "#{opts[:width]}px" : "100px"
			image = user.image 
			if image
				image = image.split('?')[0] if (size == 'small')
				image_tag( image, opts.merge( :style => "#{ image_radius(0) } #{opts[:style]}", :width => get_width ) ) 
			else
				content_tag('div', '', opts.merge( :style => "#{ image_radius(0) } #{opts[:style]}", :width => get_width, :class => 'default_profile_pic' ) )
			end
		end
	end

	def labeled_radio id, name, value, width = 100, toggle_type = "", label_id = nil
		input = raw("<input type='radio' name='#{name}' value='#{value}' class='mll fl' id='#{id}' />")
		span = content_tag 'span', value.capitalize, :class => 'mls fl'
		clearfix = content_tag 'div', ' ', :class => 'clearfix'
		
		content_tag 'label', input + span + clearfix, :for => id, :class => "radio_label #{toggle_type}", :style => "width: #{width}px;", :id => label_id
	end
	
	def pull_large_fb_pic image_url
		image_url.split('?')[0]+'?type=large'
	end

	def pull_normal_fb_pic image_url
		image_url.split('?')[0]
	end

	def fb_profile
		if current_user.authentications.find_by_provider('facebook')
			return 'http://facebook.com/profile.php?id=' + current_user.authentications.find_by_provider('facebook').uid
		else
			return '#'
		end
	end

	def full_name user
		if user
			user.first_name + " " + user.last_name
		end
	end

	def placeholder width, height
		image_tag "http://placehold.it/#{width}x#{height}"
	end
	
	# bootstrap forms field

	def bs_f form, field, opts = {}
		form_label = opts[:label].present? ? form.label(field, opts[:label], :class => 'control-label') : form.label(field, field.to_s.titleize, :class => 'control-label')

		as_field = form.text_field(field, opts) if opts[:as].nil?
		as_field = form.text_area(field, opts) if opts[:as]== 'textarea'
		as_field = form.select(field, opts[:collection], { :prompt => opts[:prompt] }, opts.except(:as, :collection, :prompt)) if opts[:as] == :select
		
		# radio buttons for collection
		if opts[:as] == :radio
			collection = opts[:collection]
			as_field = ""
			collection.each do |radio_opt|

				as_field += content_tag(
																'label', 
																(
																	radio_opt.class == Array ? (form.radio_button( field, radio_opt[0], opts.except(:as, :collection) ) + radio_opt[1]) : (form.radio_button( field, radio_opt, opts.except(:as, :collection) ) + radio_opt)
																),
																:class => "radio #{opts[:align]}"
															)
			end

		end
		
		# form_field = content_tag( 'div', as_field, :class => "controls" ) if opts[:as].nil? 
		form_field = content_tag( 'div', as_field.html_safe, :class => "controls" )
		get_row = form_label + form_field

		content_tag('div', get_row, :class => 'control-group')
	end

	def bool
		return [[true, 'Yes'], [false, 'No']]
	end
end
