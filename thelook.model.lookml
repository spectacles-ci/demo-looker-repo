# PRELIMINARIES #
- connection: thelook
- include: "*.lookml"
- label: The Look

# EXPLORES #


- explore: order_items
  joins:

    - join: orders
      type: left_outer
      sql_on: ${order_items.order_id} = ${orders.id}
      relationship: many_to_one

    - join: products
      type: left_outer
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one

    - join: users
      type: left_outer
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one

    - join: users_orders_facts
      type: left_outer
      sql_on: ${users.id} = ${users_orders_facts.user_id}
      relationship: one_to_one

    - join: inventory_items
      type: left_outer
      sql_on: ${order_items.inventory_item_id} = ${inventory_items.id}
      relationship: many_to_one
      fields: inventory_items.export        # don't import all of the fields, just the fields in this set.
      
      
- explore: orders
  joins:
    - join: users
      type: left_outer
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one

    - join: users_orders_facts
      type: left_outer
      sql_on: ${users.id} = ${users_orders_facts.user_id}
      relationship: one_to_one

- explore: users
  joins:
  - join: users_orders_facts
    type: left_outer
    sql_on: ${users.id} = ${users_orders_facts.user_id}
    relationship: one_to_one

  - join: users_revenue_facts
    type: left_outer
    sql_on: ${users.id} = ${users_revenue_facts.user_id}
    relationship: one_to_one

  - join: users_sales_facts
    type: left_outer
    sql_on: ${users.id} = ${users_sales_facts.user_id}
    relationship: one_to_one

# HIDDEN EXPLORES TO USE FOR FILTER SUGGESTIONS    
- explore: products
  hidden: true

