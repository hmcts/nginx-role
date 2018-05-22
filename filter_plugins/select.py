def map_list(list, key, default=None):
    return filter(None, (item.get(key, default) for item in list))


class FilterModule(object):
    def filters(self):
        return {
            'select': map_list
        }
