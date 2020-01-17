module ServiceOrdersHelper
  def form_url_options(form_object)
    form_url =
      if form_object.persisted?
        {method: :patch, url: service_order_path(form_object.id)}
      else
        {method: :post, url: service_orders_path}
      end
  end
end
