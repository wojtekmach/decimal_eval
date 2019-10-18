defmodule DecimalEval do
  @doc """
  Evaluates the given expr substituting operators with Decimal equivalents.

  ## Examples

      iex> a = 1
      iex> b = 2
      iex> DecimalEval.eval (a + b) * "3.0"
      Decimal.new("9.0")

      iex> DecimalEval.eval 1 == "1.0"
      true
      iex> DecimalEval.eval 1 == "1.1"
      false
      iex> DecimalEval.eval 1 < "1.0"
      false
      iex> DecimalEval.eval 1 < "1.1"
      true

  """
  defmacro eval(expr), do: do_eval(expr)

  defp do_eval(do: block), do: do_eval(block)

  defp do_eval(block) do
    operators = [+: 2, -: 2, *: 2, /: 2, ==: 2, !=: 2, <: 2, <=: 2, >: 2, >=: 2]

    quote do
      # `if` adds scope and we need it so that imports don't leak outside
      if true do
        import Kernel, except: unquote(operators)
        import DecimalEval, only: unquote(operators)
        unquote(block)
      end
    end
  end

  defdelegate a + b, to: Decimal, as: :add

  defdelegate a - b, to: Decimal, as: :sub

  defdelegate a * b, to: Decimal, as: :mult

  defdelegate a / b, to: Decimal, as: :div

  defdelegate a == b, to: Decimal, as: :eq?

  def a != b, do: not Decimal.eq?(a, b)

  defdelegate a < b, to: Decimal, as: :lt?

  def a <= b, do: Decimal.cmp(a, b) in [:eq, :lt]

  defdelegate a > b, to: Decimal, as: :gt?

  def a >= b, do: Decimal.cmp(a, b) in [:eq, :gt]
end
