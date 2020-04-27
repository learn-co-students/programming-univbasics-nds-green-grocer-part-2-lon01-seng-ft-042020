def find_item_by_name_in_collection(name, collection)
  index = 0

  collection.each do |grocery_item|
    return grocery_item if grocery_item[:item] === name 
    index += 1
  end

  nil
end


def consolidate_cart(cart)
  index = 0
  new_cart = []
  
  cart.each do |grocery_item|
    current_item = find_item_by_name_in_collection(grocery_item[:item], new_cart)
    if current_item
      new_cart_index = 0
      new_cart.each do |new_cart_item|
        if new_cart_item[:item] === current_item[:item]
          new_cart_item[:count] += 1
        end
        new_cart_index += 1
      end
    else
      grocery_item[:count] = 1
      new_cart << grocery_item
    end
    index += 1
  end
  new_cart
end

# def consolidate_cart(cart)
#   # Consult README for inputs and outputs
#   #
#   # REMEMBER: This returns a new Array that represents the cart. Don't merely
#   # change `cart` (i.e. mutate) it. It's easier to return a new thing.
#   new_cart = []

#   cart.each { |cart_item|
#     cart_item_name = cart_item[:item]
#     if !find_item_by_name_in_collection(cart_item_name, new_cart)
#       count = cart.select{ |selector| selector[:item] == cart_item_name }.length
#       new_cart.push(cart_item.merge({:count => count}))
#     end
#   }

#   new_cart

# end