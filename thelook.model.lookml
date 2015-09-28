# PRELIMINARIES #
- connection: thelook
- scoping: true                          # for backward compatibility
- include: "*.lookml"
- template: liquid
- label: The Look

# EXPLORES #


- explore: order_items
  joins:

    - join: orders
      foreign_key: order_items.order_id

    - join: products
      foreign_key: inventory_items.product_id

    - join: users
      foreign_key: orders.user_id

    - join: users_orders_facts
      foreign_key: users.id
  
    - join: inventory_items
      foreign_key: order_items.inventory_item_id
      fields: inventory_items.export        # don't import all of the fields, just the fields in this set.
      
      
- explore: orders
  joins:
    - join: users
      foreign_key: orders.user_id

    - join: users_orders_facts
      foreign_key: users.id
    
- explore: users
  joins:
  - join: users_orders_facts
    foreign_key: users.id

  - join: users_revenue_facts
    foreign_key: users.id   
    relationship: one_to_one

  - join: users_sales_facts
    foreign_key: users.id
    
# HIDDEN EXPLORES TO USE FOR FILTER SUGGESTIONS    
- explore: products
  hidden: true

