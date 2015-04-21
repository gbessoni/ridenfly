class Rate::PickupTimeMerger < Struct.new(:list, :pickup_times)
  PICKUP_TIMES_SEP = '|'

  def attrs
    {}.tap do |result|

      times = (list || '').split(PICKUP_TIMES_SEP).uniq.map(&:strip)
      times += [nil] * (pickup_times.size - times.size) if pickup_times.size > times.size

      times.zip(pickup_times).each_with_index do |(t, obj), i|
        oid = obj.try(:id) || i
        result[oid] ||= {}
        result[oid].merge!(id: oid) if obj.present?
        if t.present?
          result[oid].merge!(pickup_str: t)
        else
          result[oid].merge!(_destroy: 1)
        end
      end

    end
  end
end
