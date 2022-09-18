require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do 
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    @invoice_items_1 = create(:invoice_items, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_items_2 = create(:invoice_items, invoice_id: @invoice_2.id, item_id: @item_2.id)
  end

  # As a merchant
  # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
  # Then I see information related to that invoice including:

  # Invoice id
  # Invoice status
  # Invoice created_at date in the format "Monday, July 18, 2019"
  # Customer first and last name

  describe 'User Story 15 - When I visit my merchants invoice show page' do 
    it 'Then I see information related to that invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#invoice-info") do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status)
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@invoice_1.customer.first_name)
        expect(page).to have_content(@invoice_1.customer.last_name )
        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_2.customer.first_name)
        expect(page).to_not have_content(@invoice_2.customer.last_name)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_2)

      within("#invoice-info") do
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_2.status)
        expect(page).to have_content(@invoice_2.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@invoice_2.customer.first_name)
        expect(page).to have_content(@invoice_2.customer.last_name )
        expect(page).to_not have_content(@invoice_1.id)
        expect(page).to_not have_content(@invoice_1.customer.first_name)
        expect(page).to_not have_content(@invoice_1.customer.last_name )
      end
    end
  end

  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see all of my items on the invoice including:

  # Item name
  # The quantity of the item ordered
  # The price the Item sold for
  # The Invoice Item status
  # And I do not see any information related to Items for other merchants

  describe 'User Story 16 - When I visit my merchant invoice show page' do
    it 'Then I see all of my items on the invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#invoice-items-info") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.unit_price)
        expect(page).to have_content(@invoice_items_1.status)
        expect(page).to have_content(@invoice_items_1.quantity)
        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@item_2.unit_price)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_2)

      within("#invoice-items-info") do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.unit_price)
        expect(page).to have_content(@invoice_items_2.status)
        expect(page).to have_content(@invoice_items_2.quantity)
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_1.unit_price)
        expect(page).to_not have_content(@invoice_items_1.quantity)
      end
    end
  end
end