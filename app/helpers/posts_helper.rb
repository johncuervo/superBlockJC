module PostsHelper
  def form_title
    @post.new_record? ? "Publicar Producto" : "Modificar Producto"
  end
end
