require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
  counter +=1
  end
  cart
end
  
  # new_array = []
  # cart.each do |item_hash|
  #   existe = find_item_by_name_in_collection(item_hash[:item], coupons)
    
  #   #binding.pry
  #   if existe #does it have coupon?
  #   #binding.pry
  #     coupons.each do |coupons_item_hash|
  #         #binding.pry
  #         if coupons_item_hash[:item] == existe[:item]
  #           ind_price = nil
  #           ind_price = (coupons_item_hash[:cost]/coupons_item_hash[:num]).round(2)
  #           rest = nil
  #           rest = existe
  #           # coupons_item_hash.delete(:num)
  #           # coupons_item_hash.delete(:cost)
  #           # coupons_item_hash[:price] = ind_price
  #         binding.pry
  #         end
  #     end
  #     #if existe = false
  #     new_array.push(item_hash)
  #   end
  #   #binding.pry
  # end
  # return new_array


def apply_clearance(cart)
  cart.each do |hash|
    if hash[:clearance] == true
      hash[:price] = (hash[:price] * 0.8).round(2)
      #binding.pry
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  cart_coupons_applied = apply_coupons(consolidated_cart, coupons)
  cart_clearance_applied = apply_clearance(cart_coupons_applied)
  total = 0
  price = nil
  #binding.pry
  cart_clearance_applied.each do |hash|
    price = (hash[:price] * hash[:count]).round(2)
    total = total + price
    #binding.pry
  end
  if total > 100
    total = (total*0.9).round(2)
  end
  return total
end
