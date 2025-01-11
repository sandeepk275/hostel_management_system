module ResponseConcern
	def build_json_response(status, success, message, data = nil)
		response = { status: status, success: success, message: message}
	  response.merge!(data) if data.present? && (data.is_a? Hash)
	  return render json: response, status: status
	end

	def serialize(records, serializer: nil, params: {})
    return build_response(422, false, "Serializer is missing") unless serializer
    serializer.new(records, params: params).serializable_hash
  end
end