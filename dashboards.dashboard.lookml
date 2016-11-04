#----------------------------
- dashboard: 1_business_pulse
#----------------------------
  title: "1) Business Pulse"
  layout: grid
  rows:
    - elements: [total_orders, average_order_profit, first_purchasers]
      height: 180
    - elements: [orders_by_day_and_category, yoy_sales]
      height: 400
    - elements: [sales_state_map, top_zips_map]
      height: 400
    - elements: [sales_by_date_and_category, top_10_brands]
      height: 400
    - elements: [cohort_text]
      height: 150
    - elements: [layer_cake_cohort, cum_cohort]
      height: 400
    - elements: [customer_cohort]
      height: 400

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: Last 90 Days

  - name: state
    title: 'State'
    type: field_filter
    explore: users
    field: users.state



  elements:

  - name: total_orders
    type: single_value
    explore: orders
    measures: [orders.count]
    listen:
      date: orders.created_date
      state: users.state
    font_size: medium

  - name: average_order_profit
    type: single_value
    explore: orders
    measures: [orders.average_order_profit]
    listen:
      date: orders.created_date
      state: users.state
    font_size: medium

  - name: first_purchasers
    type: single_value
    explore: orders
    measures: [orders.first_purchase_count]
    listen:
      date: orders.created_date
      state: users.state
    font_size: medium

  - name: orders_by_day_and_category
    title: "Orders by Day and Category"
    type: looker_area
    explore: order_items
    dimensions: [orders.created_date]
    pivots: [products.category_name]
    measures: [order_items.count]
    filters:
      products.category_name: Blazers & Jackets, Sweaters, Pants, Shorts, Fashion Hoodies & Sweatshirts, Accessories
    listen:
      date: orders.created_date
      state: users.state
    sorts: [orders.created_date]
    limit: 500
    colors: ["#651F81", "#80237D", "#C488DD", "#Ef7F0F", "#FEAC47", "#8ED1ED"]
    legend_align:
    y_axis_labels: "# Order Items"
    stacking: normal
    x_axis_datetime: yes
    hide_points: yes
    hide_legend: yes
    x_axis_datetime_tick_count: 4
    show_x_axis_label: false

  - name: yoy_sales
    title: "Year over Year Sales"
    type: looker_line
    model: thelook
    explore: order_items
    dimensions: [orders.created_year, orders.created_month_name]
    pivots: [orders.created_year]
    fill_fields: [orders.created_year, orders.created_month_name]
    measures: [order_items.total_sale_price]
    filters:
      orders.created_date: before 0 months ago
      orders.created_year: after 2012/01/01
    sorts: [orders.created_year, orders.created_year, orders.created_month_name]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    series_colors: {}
    series_types: {}
    hidden_series: []
    colors: ['#651F81', '#80237D', '#C488DD', '#Ef7F0F', '#FEAC47', '#8ED1ED']


  - name: top_zips_map
    title: "Top Zip Codes"
    type: looker_map
    model: thelook
    explore: order_items
    dimensions: [users.zip]
    measures: [order_items.count]
    filters:
      users.is_lower_48: yes
    listen:
      date: orders.created_date
      state: users.state
    sorts: [order_items.count desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_opacity: 1
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    map: usa
    colors: [gold, orange, darkorange, orangered, red]
    point_color: '#651F81'
    point_radius: 3
    map_projection: ''
    series_types: {}
    map_latitude: 38.03078569382294
    map_longitude: -98.8330078125
    map_zoom: 4


  - name: sales_state_map
    title: "Sales by State"
    type: looker_map
    model: thelook
    explore: order_items
    dimensions: [users.state]
    measures: [order_items.total_sale_price]
    filters:
      users.is_lower_48: yes
    listen:
      date: orders.created_date
      state: users.state
    sorts: [order_items.total_sale_price desc]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: false
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    map: usa
    colors: ['#651F81']
    map_projection: ''
    quantize_colors: false
    series_types: {}
    map_latitude: 39.027718840211605
    map_longitude: -94.482421875
    map_zoom: 3
    map_value_colors: [green, red]
    map_value_scale_clamp_min:
    map_value_scale_clamp_max:
    hidden_fields:


  - name: sales_by_date_and_category
    title: "Sales by Date and Category (Last 6 Weeks)"
    type: looker_donut_multiples
    explore: order_items
    dimensions: [orders.created_week]
    pivots: [products.category_name]
    measures: [order_items.count]
    filters:
      orders.created_date: 6 weeks ago for 6 weeks
      products.category_name: Accessories, Active, Blazers & Jackets, Clothing Sets
    sorts: [orders.created_week desc]
    colors: ["#651F81","#EF7F0F","#555E61","#2DA7CE"]
    limit: 24
    charts_across: 3
    show_value_labels: true

  - name: top_10_brands
    title: "Top 15 Brands"
    type: table
    explore: order_items
    dimensions: [products.brand_name]
    measures: [order_items.count, order_items.total_sale_price, order_items.average_sale_price]
    listen:
      date: orders.created_date
      state: users.state
    sorts: [order_items.count desc]
    limit: 15

  - name: layer_cake_cohort
    title: "Cohort - Orders Layered by Sign Up Month"
    type: looker_area
    explore: orders
    dimensions: [orders.created_month]
    pivots: [users.created_month]
    measures: [orders.count]
    filters:
      orders.created_month: 12 months ago for 12 months
      users.created_month: 12 months ago for 12 months
    sorts: [orders.created_month]
    limit: 500
    y_axis_labels: ["Number of orders"]
    x_axis_label: "Order Month"
    legend_align: right
    colors: ["#FF0000","#DE0000","#C90000","#9C0202","#800101","#6B0000","#4D006B","#0D0080","#080054","#040029","#000000"]
    stacking: normal
    hide_points: yes

  - name: cohort_text
    type: text
    title_text: 'Cohort Analysis'
    subtitle_text: 'Customers by Signup Month'
#     body_text: 'body text'

  - name: cum_cohort
    title: Untitled Visualization
    type: looker_line
    model: thelook
    explore: order_items
    dimensions: [orders.months_since_user_created_sharp, users.created_month]
    pivots: [users.created_month]
    fill_fields: [users.created_month]
    measures: [order_items.total_sale_price]
    dynamic_fields:
    - table_calculation: total_sale_price
      label: Total Sale Price
      expression: |-
        if(
        is_null(${order_items.total_sale_price})
        ,null
        ,running_total(${order_items.total_sale_price}))
      value_format:
      value_format_name: usd
    filters:
      orders.months_since_user_created_sharp: '[0, 12]'
      users.created_month: 12 months ago for 12 months
    sorts: [users.created_month, orders.months_since_user_created_sharp]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: '#808080'
    hide_legend: false
    series_colors: {}
    series_types: {}
    x_axis_label_rotation: 0
    colors: ['#FF0000', '#DE0000', '#C90000', '#9C0202', '#800101', '#6B0000', '#4D006B',
      '#0D0080', '#080054', '#040029', '#000000']
    hidden_fields: [order_items.total_sale_price]



  - name: customer_cohort
    type: table
    explore: orders
    dimensions: [users.created_month]
    pivots: [orders.created_month]
    measures: [users.count]
    filters:
      orders.created_month: 12 months ago for 12 months
      users.created_month: 12 months ago for 12 months
    sorts: [users.created_month]
    limit: 500

#----------------------------
- dashboard: 2_brand_overview
#----------------------------
  title: "2) Brand Overview"
  layout: grid
  show_applied_filters: false
  rows:
    - elements: [total_orders, total_customers, average_order_value]
      height: 180
    - elements: [sales_over_time]
      height: 300
    - elements: [sales_by_department_and_category, connoisseur]
      height: 400

  filters:



  - name: brand
    title: 'Brand Name'
    type: field_filter
    explore: products
    field: products.brand_name
    default_value: Calvin Klein


  - name: date
    title: "Date"
    type: date_filter
    default_value: Last 90 Days

  elements:

  - name: total_orders
    type: single_value
    explore: order_items
    measures: [orders.count]
    listen:
      date: orders.created_date
      brand: products.brand_name
    font_size: medium

  - name: total_customers
    type: single_value
    explore: order_items
    measures: [users.count]
    listen:
      date: orders.created_date
      brand: products.brand_name
    font_size: medium

  - name: average_order_value
    type: single_value
    explore: order_items
    measures: [order_items.average_sale_price]
    listen:
      date: orders.created_date
      brand: products.brand_name
    font_size: medium

  - name: sales_over_time
    title: Sales
    type: looker_line
    explore: order_items
    dimensions: [orders.created_date]
    measures: [order_items.total_sale_price, order_items.average_sale_price]
    listen:
      brand: products.brand_name
    filters:
      orders.created_date: 90 days
    limit: 500
    x_axis_datetime: yes
    hide_points: yes
    show_view_names: false
    y_axis_combined: true
    show_x_axis_label: false
    series_labels:
      order_items.total_sale_price: Total Sales
      order_items.average_sale_price: Average Sale Price
    series_colors:
      order_items.total_sale_price: purple
      order_items.average_sale_price: orange

  - name: sales_by_department_and_category
    title: "Sales by Department and Category"
    type: table
    explore: order_items
    dimensions: [products.category_name]
    pivots: [products.department_name]
    measures: [order_items.count, order_items.total_sale_price]
    listen:
      date: orders.created_date
      brand: products.brand_name
    sorts: [order_items.count desc]
    limit: 500

  - name: connoisseur
    title: Top Purchasers
    type: table
    explore: order_items
    dimensions: [users.name, users.email, users.history]
    measures: [order_items.count, order_items.total_sale_price]
    listen:
      date: orders.created_date
      brand: products.brand_name
    sorts: [order_items.count desc]
    limit: 15

#-----------------------------
- dashboard: 3_category_lookup
#-----------------------------
  title: "3) Category Lookup"
  layout: grid
  rows:
    - elements: [total_orders, total_customers, average_order_value]
      height: 180
    - elements: [comparison, sales_by_day]
      height: 400
    - elements: [demographic, top_brands_within_category]
      height: 400

  filters:

  - name: category
    title: 'Category Name'
    type: field_filter
    explore: products
    field: products.category_name
    default_value: Jeans

  - name: department
    title: 'Department'
    type: field_filter
    explore: products
    field: products.department_name



  - name: date
    title: "Date"
    type: date_filter
    default_value: Last 90 Days

  elements:

  - name: total_orders
    type: single_value
    explore: order_items
    measures: [orders.count]
    listen:
      category: products.category_name
      date: orders.created_date
      department: products.department_name
    font_size: medium

  - name: total_customers
    type: single_value
    explore: order_items
    measures: [users.count]
    listen:
      date: orders.created_date
      category: products.category_name
      department: products.department_name
    font_size: medium

  - name: average_order_value
    type: single_value
    explore: order_items
    measures: [order_items.average_sale_price]
    listen:
      date: orders.created_date
      category: products.category_name
      department: products.department_name
    font_size: medium

  - name: comparison
    title: "All Categories Comparison"
    type: table
    explore: order_items
    dimensions: [products.category_name]
    measures: [order_items.average_sale_price, users.count, orders.count]
    listen:
      date: orders.created_date
      department: products.department_name
    sorts: [order_items.average_sale_price desc]
    limit: 50

  - name: sales_by_day
    title: "Sales by Date"
    type: looker_line
    explore: order_items
    dimensions: [orders.created_date]
    measures: [order_items.average_sale_price, order_items.total_sale_price]
    listen:
      date: orders.created_date
      category: products.category_name
      department: products.department_name
    sorts: [orders.created_date]
    x_axis_datetime: yes
    y_axis_orientation: [left,right]
    y_axis_labels: ["Average Selling Price ($)","Total Sale Amount ($)"]
    hide_points: yes

  - name: demographic
    title: "Age Demographic"
    type: looker_column
    explore: order_items
    dimensions: [users.age_tier]
    measures: [order_items.average_sale_price, order_items.count]
    listen:
      date: orders.created_date
      category: products.category_name
      department: products.department_name
    sorts: [users.age_tier]
    limit: 500
    x_axis_label: "Age Tier"
    y_axis_orientation: [left,right]
    y_axis_labels: ["Average Selling Price ($)","# orders"]

  - name: top_brands_within_category
    title: "Top Brands"
    type: table
    explore: order_items
    dimensions: [products.brand_name]
    measures: [order_items.count, order_items.total_sale_price]
    listen:
      date: orders.created_date
      category: products.category_name
      department: products.department_name
    sorts: [order_items.total_sale_price desc]
    limit: 25

#-------------------------
- dashboard: 4_user_lookup
#-------------------------
  title: "4) User Lookup"
  show_applied_filters: false
  layout: grid
  rows:
    - elements: [lifetime_orders, total_items_returned, lifetime_spend]
      height: 180
    - elements: [user_info, item_order_history, favorite_categories]
      height: 400

  filters:

  - name: email
    title: 'Email'
    type: field_filter
    explore: users
    field: users.email

  elements:

  - name: user_info
    title: "User Info"
    type: looker_single_record
    explore: order_items
    dimensions: [users.id, users.email, users.name, users.created_month, users.age,
      users.state, users.city, users.zip, users.history]
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    limit: 500
    show_null_labels: false

  - name: lifetime_orders
    title: "Lifetime Orders"
    type: single_value
    explore: order_items
    measures: [orders.count]
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    sorts: [orders.count desc]
    limit: 500
    show_null_labels: false

  - name: total_items_returned
    title: "Total Items Returned"
    type: single_value
    explore: order_items
    measures: [order_items.count]
    filters:
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    sorts: [order_items.count desc]
    limit: 500
    show_null_labels: false

  - name: lifetime_spend
    title: "Lifetime Spend"
    type: single_value
    explore: order_items
    measures: [order_items.total_sale_price]
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    sorts: [order_items.total_sale_price desc]
    limit: 500
    show_null_labels: false

  - name: item_order_history
    title: "Items Order History"
    type: table
    explore: order_items
    dimensions: [products.item_name]
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    sorts: [products.item_name]
    limit: 500

  - name: favorite_categories
    title: "Favorite Categories"
    type: looker_pie
    explore: order_items
    dimensions: [products.category_name]
    measures: [order_items.count]
    listen:
      email: users.email
    filters:
      orders.created_date: 99 years
    sorts: [order_items.count desc]
    limit: 500

#----------------------------------------
- dashboard: sample_dashboard_with_images
#----------------------------------------
  title: 'Product Dashboard With Images'
  layout: grid
  tile_size: 100

#  filters:

  rows:
  - height: 1000
    elements: [dashboard_with_images]

  elements:
  - name: dashboard_with_images
    title: 'Product Dashboard with Images'
    type: table
    model: thelook
    explore: products
    dimensions: [products.id, products.category_name, products.brand_name, products.item_name, products.product_image,
      products.retail_price]
    filters:
      products.id: '2671,7612,17264,24492,7201,3388,603,19921,25175,3607,21479,21397,14605,10249,1448,4859,6028,14359,17866,9933,24074,22444,11972,11380,4357,3796,16321,9261,6732,13204'
    sorts: [products.id]
    limit: 500
    total: false
