class Cart < ActiveRecord::Base
    has_many :line_items
    has_many :items, through: :line_items
    belongs_to :user
    

    def total
        total = 0
        self.line_items.each do |line_item|
            total += line_item.item.price * line_item.quantity
        end
        return total      
    end

    def add_item(item_id)
        if item_ids.include?(item_id.to_i)
          current_line_item = line_items.find_by(item_id: item_id)
          current_line_item.quantity += 1
          current_line_item
        else
          line_items.build(item_id: item_id, quantity: 1)
        end
      end

      def change_inventory
        if self.status = "submitted"
          self.line_items.each do |line_item|
            line_item.item.inventory -= line_item.quantity
            line_item.item.save
          end
        end
      end

      def checkout
        remove_inventory
        user.remove_cart
        update(status: 'submitted')
      end

      def remove_inventory
        line_items.each do |line_item|
          line_item.item.remove(line_item.quantity)
        end
      end
end
