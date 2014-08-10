class Post < ActiveRecord::Base

	scope :basic, lambda { select("autor, data_hora, comments, imagem") }

end
