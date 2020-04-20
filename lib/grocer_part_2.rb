require_relative './part_1_solution.rb'

grocery_shelf = [
  { :item => "CANNED BEANS", :price => 3.00, :clearance => true },
  { :item => "CANNED CORN", :price => 2.50, :clearance => false },
  { :item => "SALSA", :price => 1.50, :clearance => false },
  { :item => "TORTILLAS", :price => 2.00, :clearance => false },
  { :item => "HOT SAUCE", :price => 1.75, :clearance => false }
]

shopping_cart = [
  { :item => "CANNED BEANS", :price => 3.00, :clearance => true },
  { :item => "CANNED CORN", :price => 2.50, :clearance => false },
  { :item => "SALSA", :price => 1.50, :clearance => false },
  { :item => "TORTILLAS", :price => 2.00, :clearance => false },
  { :item => "HOT SAUCE", :price => 1.75, :clearance => false },
  { :item => "HOT SAUCE", :price => 1.75, :clearance => false },
  { :item => "HOT SAUCE", :price => 1.75, :clearance => false }

]

my_coupons = [
  { :item => "HOT SAUCE", :num => 2, :cost => 3.00 }
]


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  #Debug Prints
  # puts "cart:"
  # puts cart
  # puts "coupons:"
  # puts coupons
  
  coupon_cart =[]

  new_cart = cart.map{|product|
    coupon = find_item_by_name_in_collection(product[:item], coupons)
    if coupon
      coupon[:clearance] = product[:clearance]
      coupon[:count] =  product[:count] / coupon[:num]
      coupon_cart.push(coupon)
      product[:count] = (product[:count] % coupon[:num])
    end
    product
  }

  #new_cart is an array of items with their counts less coupons
  #coupon_cart is an array of coupons in the format {:item, :cost, :clearance, :count}

  # #Debug Prints
  # puts "new_cart:"
  # puts new_cart

  # puts "coupon_cart"
  # puts coupon_cart

  
   coupon_cart.each {|coupon|
    if coupon[:count] > 0
      cart_item = {
        :item => "#{coupon[:item]} W/COUPON",
        :price => (coupon[:cost]/coupon[:num]),
        :clearance => coupon[:clearance],
        :count => (coupon[:count]*coupon[:num])
      }
      new_cart.push(cart_item)
    end
   }

  cart = new_cart #.select {|product| product[:count]}

  cart

  #Debug Prints
  
  # puts "result_cart"
  # puts cart

  cart


end




def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  

  cart.map!{ |product|
    if product[:clearance]
      product[:price] = (product[:price]*0.8).round(2)
    end
    product
  }
  
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
    
  new_cart = consolidate_cart(cart)

  cart_w_coupons = apply_coupons(new_cart, coupons)
  
  cart_w_clearance = apply_clearance(cart_w_coupons)
  
  total = cart_w_clearance.reduce(0){|memo, product| memo + (product[:price]*product[:count])}

  if total > 100
    total *= 0.90
  end

  total

end

