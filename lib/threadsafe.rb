# Only put core objects here.
# Additional libraries should define threadsafe-ness for themselves.
#   (Otherwise, we'd either have to require them here, or intercept every
#    require, which we can't do until autoload is fixed.)

unsafe_classes = [
  # Default to false
  Object
]

safe_classes = [
  # Immutables
  TrueClass,
  FalseClass,
  NilClass,
  Symbol,
  Numeric
]

# TODO: Are frozen strings safe? If so, what's the sanest implementation?
# Since #freeze and #frozen? seem to exist on Object, it can't be global.


# Unrolled to avoid ugly evals or define_method overhead.
# It's simple enough anyway.

safe_classes.each do |klass|
  klass.class_eval do
    unless method_defined? :threadsafe?
      def threadsafe?; true; end
    end
  end
end

unsafe_classes.each do |klass|
  klass.class_eval do
    unless method_defined? :threadsafe?
      def threadsafe?; false; end
    end
  end
end