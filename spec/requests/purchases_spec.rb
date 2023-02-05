# require 'swagger_helper'

# RSpec.describe 'purchases', type: :request do
#   path '/buy' do
#     post('buy') do
#       operationId 'buyProduct'
#       description 'Buy a product given its id and the desired amount'
#       produces 'application/json'

#       parameter name: :product_id, in: :body, schema: {
#         type: :object,
#         properties: {
#           product_id: { type: :integer },
#           amount_of_products: { type: :integer }
#         },
#         required: %w[product_id amount_of_products]
#       }

#       after do |example|
#         example.metadata[:response][:content] = {
#           'application/json' => {
#             example: JSON.parse(response.body, symbolize_names: true)
#           }
#         }
#       end
#     end
#   end
# end
