defmodule Packet.TokenStreamTest do
  use ExUnit.Case, async: true

  @login_response <<
  # HEADER
  0x04, 0x01, 0x01, 0x61, 0x00, 0x00, 0x01, 0x00,
  # ENVCHANGE
  0xE3, 0x1B, 0x00, 0x01, 0x06, 0x6D, 0x00, 0x61,
  0x00, 0x73, 0x00, 0x74, 0x00, 0x65, 0x00, 0x72, 0x00, 0x06, 0x6D, 0x00, 0x61, 0x00, 0x73, 0x00,
  0x74, 0x00, 0x65, 0x00, 0x72, 0x00,
  # INFO
  0xAB, 0x58, 0x00, 0x45, 0x16, 0x00, 0x00, 0x02, 0x00, 0x25,
  0x00, 0x43, 0x00, 0x68, 0x00, 0x61, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x65, 0x00, 0x64, 0x00, 0x20,
  0x00, 0x64, 0x00, 0x61, 0x00, 0x74, 0x00, 0x61, 0x00, 0x62, 0x00, 0x61, 0x00, 0x73, 0x00, 0x65,
  0x00, 0x20, 0x00, 0x63, 0x00, 0x6F, 0x00, 0x6E, 0x00, 0x74, 0x00, 0x65, 0x00, 0x78, 0x00, 0x74,
  0x00, 0x20, 0x00, 0x74, 0x00, 0x6F, 0x00, 0x20, 0x00, 0x27, 0x00, 0x6D, 0x00, 0x61, 0x00, 0x73,
  0x00, 0x74, 0x00, 0x65, 0x00, 0x72, 0x00, 0x27, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00,
  # ENVCHANGE
  0xE3, 0x08, 0x00, 0x07, 0x05, 0x09, 0x04, 0xD0, 0x00, 0x34, 0x00,
  # ENVCHANGE
  0xE3, 0x17, 0x00, 0x02, 0x0A, 0x75, 0x00, 0x73, 0x00, 0x5F, 0x00, 0x65, 0x00, 0x6E, 0x00, 0x67,
  0x00, 0x6C, 0x00, 0x69, 0x00, 0x73, 0x00, 0x68, 0x00, 0x00,
  # ENVCHANGE
  0xE3, 0x13, 0x00, 0x04, 0x04, 0x34, 0x00, 0x30, 0x00, 0x39,
  0x00, 0x36, 0x00, 0x04, 0x34, 0x00, 0x30, 0x00, 0x39, 0x00, 0x36, 0x00,
  # INFO
  0xAB, 0x5C, 0x00,
  0x47, 0x16, 0x00, 0x00, 0x01, 0x00, 0x27, 0x00, 0x43, 0x00, 0x68, 0x00, 0x61, 0x00, 0x6E, 0x00, 0x67,
  0x00, 0x65, 0x00, 0x64, 0x00, 0x20, 0x00, 0x6C, 0x00, 0x61, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x75,
  0x00, 0x61, 0x00, 0x67, 0x00, 0x65, 0x00, 0x20, 0x00, 0x73, 0x00, 0x65, 0x00, 0x74, 0x00, 0x74,
  0x00, 0x69, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x20, 0x00, 0x74, 0x00, 0x6F, 0x00, 0x20, 0x00, 0x75,
  0x00, 0x73, 0x00, 0x5F, 0x00, 0x65, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x6C, 0x00, 0x69, 0x00, 0x73,
  0x00, 0x68, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  # LOGINACK
  0xAD, 0x32, 0x00, 0x01, 0x72,
  0x09, 0x00, 0x02, 0x14, 0x4D, 0x00, 0x69, 0x00, 0x63, 0x00, 0x72, 0x00, 0x6F, 0x00, 0x73, 0x00,
  0x6F, 0x00, 0x66, 0x00, 0x74, 0x00, 0x20, 0x00, 0x53, 0x00, 0x51, 0x00, 0x4C, 0x00, 0x20, 0x00,
  0x53, 0x00, 0x65, 0x00, 0x72, 0x00, 0x76, 0x00, 0x65, 0x00, 0x72, 0x00,
  0xE, 0x0, 0x5A, 0x1,
  # DONE
  0xFD, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  >>

  @login_response_ts [
    envchange: {:database, "master"},
    info: %{class: 0, line_number: 0, msg_text: "Changed database context to 'master'.", number: 5701, proc_name: "", server_name: "", state: 2},
    envchange: {:collation, %Tds.Protocol.Collation{codepage: "WINDOWS-1252", col_flags: 0, lcid: 36941, sort_id: 52, version: 0}},
    envchange: {:language, "us_english"},
    envchange: {:packetsize, 4096},
    info: %{class: 0, line_number: 0, msg_text: "Changed language setting to us_english.", number: 5703, proc_name: "", server_name: "", state: 1},
    loginack: %{program: "Microsoft SQL Server", t_sql_only: true, tds_version: 1913192450, version: "14.0.90.1"},
    done: %{cmd: <<0, 0>>, rows: nil, status: %{atnn?: false, count?: false, error?: false, final?: true, inxact?: false, more?: false, rpc_in_batch?: false, srverror?: false}}
  ]

  test "should decode login response" do
    <<_::binary-(8), token_stream::binary>> = @login_response
    assert @login_response_ts == Tds.Tokens.decode_tokens(token_stream, nil)
  end
end
