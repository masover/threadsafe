# Only put core objects here.
# Additional libraries should define threadsafe-ness for themselves.
#   (Otherwise, we'd either have to require them here, or intercept every
#    require, which we can't do until autoload is fixed.)

{
  # Default to false
  Object => false
}.each_pair do |klass, safe|
  klass.class_eval do
    unless method_defined? :threadsafe?
      # Hack to avoid define_method overhead
      if safe
        def threadsafe?; true; end
      else
        def threadsafe?; false; end
      end
    end
  end
end