module UsersHelper
  def ymconvn(yyyymm)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    return yyyy + "年" + mm + "月 "
  end
end
