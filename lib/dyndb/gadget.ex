defmodule Dyndb.Gadget do
  use Ash.Api

  resources do
    resource Dyndb.Gadget.Compass
  end
end
