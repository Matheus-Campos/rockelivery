defmodule Rockelivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  import Plug.Conn
  import Rockelivery.Factory

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Client

  setup do
    bypass = Bypass.open()

    {:ok, bypass: bypass}
  end

  describe "get_cep_info/1" do
    test "when the cep is valid, returns the cep info", %{bypass: bypass} do
      cep = "01001000"

      url = endpoint_url(bypass.port)

      body = ~s({
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected_response = {:ok, build(:via_cep_response)}

      assert response == expected_response
    end

    test "when cep is invalid, returns an error", %{bypass: bypass} do
      cep = "123"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        resp(conn, 400, "")
      end)

      response = Client.get_cep_info(url, cep)

      expected_response = {:error, %Error{result: "Invalid CEP", status: :bad_request}}

      assert response == expected_response
    end

    test "when cep is not found, returns an error", %{bypass: bypass} do
      cep = "12345678"

      url = endpoint_url(bypass.port)

      body = ~s({"erro": true})

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected_response = {:error, %Error{result: "CEP not found", status: :not_found}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      cep = "12345678"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_cep_info(url, cep)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
