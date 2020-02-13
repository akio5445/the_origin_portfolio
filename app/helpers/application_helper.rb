module ApplicationHelper
  include SessionsHelper
  include MarkdownHelper
end

  ## viewの表示を20XX年XX月(X)日にする
  #def ymconv(yyyymm,cnt)
  #  yyyy = yyyymm[0,4]
  #  mm = yyyymm[4,2]
  #  return yyyy + "年" + mm + "月 (" + cnt + ")"
  #end
