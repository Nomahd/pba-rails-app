class ViewTesterController < ApplicationController
  def test
    @result = [55, [1,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55,2,3,4,5,6,7,8,9, 55]]

    render 'common/bulk-fail'
  end
end
