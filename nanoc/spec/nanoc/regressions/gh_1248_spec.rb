# frozen_string_literal: true

describe 'GH-1248', site: true, stdio: true do
  before do
    File.write('content/stuff.html', 'hi')

    File.write('Rules', <<~EOS)
      preprocess do
        @config[:output_dir] = 'ootpoot'
      end

      passthrough '/**/*'
    EOS
  end

  before do
    Nanoc::OrigCLI.run(%w[compile])
  end

  example do
    expect { Nanoc::OrigCLI.run(%w[compile --verbose]) }
      .not_to output(/identical .* ootpoot\/stuff.html/).to_stdout
  end
end
