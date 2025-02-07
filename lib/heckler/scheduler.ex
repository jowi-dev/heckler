defmodule Heckler.Scheduler do
  @moduledoc """
  This module is the core foundation to Heckler. It will determine the appropriate scheduling engine
  set by the calling application, and using that engine it will schedule notifications to be sent.
  One caveat is the `now` timeline that can be run without a scheduler, but will also need to be sent in thread
  """
end
