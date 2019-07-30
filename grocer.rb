require 'pry'
def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do | item |
    current_key = item.keys[0]
    if !consolidated_cart[current_key]
      consolidated_cart[current_key] = item[current_key]
      consolidated_cart[current_key][:count] = 1
    else
      consolidated_cart[current_key][:count] += 1
   end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do | coupon |
      if cart.keys.include?(coupon[:item]) 
        key=coupon[:item]
        if cart[key][:count] >= coupon[:num]
          new_key = key + " W/COUPON"
          num_coupons = cart[key][:count]/coupon[:num].floor
          cart[new_key] = {
            price: coupon[:cost]/coupon[:num],
            clearance: cart[key][:clearance],
            count: num_coupons * coupon[:num]
          }
          cart[key][:count] -= num_coupons * coupon[:num] 
        end
      end
    end
  # end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each { | key, value | value[:clearance] ? value[:price] = (value[:price] * 0.8).round(1) : nil }
end

def checkout(cart, coupons)
  # code here
  total = 0
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  cart_with_clearance = apply_clearance(cart_with_coupons)
  cart_with_clearance.each do | key, value |
    total += value[:price] * value[:count]
  end
  total > 100 ? total *= 0.9 : total
end
