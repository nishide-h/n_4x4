# frozen_string_literal: true

json.array! @sheets, partial: "sheets/sheet", as: :sheet
