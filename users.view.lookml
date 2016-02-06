- view: users
  fields:

# DIMENSIONS # 

  - dimension: id
    type: number
    primary_key: true
    sql: ${TABLE}.id 

  - dimension: age
    type: number
    
  - measure: average_age
    type: average
    value_format_name: decimal_2
    sql: ${age}

  - dimension: age_tier
    type: tier
    style: integer
    sql: ${age}
    tiers: [0,10,20,30,40,50,60,70,80]

  - dimension: city

  - dimension: country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.created_at

  - dimension: email
    html: |
      {{ linked_value }}
      <a href="/dashboards/thelook/4_user_lookup?email={{ value | encode_uri }}" target="_new">
      <img src="/images/qr-graph-line@2x.png" height=20 width=20></a>  

  - dimension: gender

  - dimension: name
    sql: CONCAT(${TABLE}.first_name,' ', ${TABLE}.last_name)

  - dimension: history
    sql: ${TABLE}.id
    html: |
      <a href="/explore/thelook/orders?fields=orders.detail*&f[users.id]={{ value }}">Orders</a>
      | <a href="/explore/thelook/order_items?fields=order_items.detail*&f[users.id]={{ value }}">Items</a>
  
  - dimension: state


  - dimension: zip
    hidden: true
    type: zipcode

  - dimension: zipcode
    type: zipcode
    sql: ${zip}

# MEASURES #

  - measure: count
    type: count
    drill_fields: detail

  - measure: count_percent_of_total
    label: Count (Percent of Total)
    type: percent_of_total
    drill_fields: detail*
    value_format_name: decimal_1
    sql: ${count}


# SETS #

  sets:
    detail:
      - id
      - name
      - email
      - city
      - state
      - country
      - zip
      - gender
      - age
      - history
        # Counters for views that join 'users'
      - orders.count
      - order_items.count