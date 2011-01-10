from hashlib import md5


def make_desktop_key(username, desktop_slug):
    return "desktop.%s.%s" % (username, desktop_slug)
    

def get_desktop_hash(username, slug):
    return md5(make_desktop_key(username, slug)).hexdigest()
    

def get_desktop_hash_path(username, slug):
    desktop_hash = get_desktop_hash(username, slug)
    desktop_hash_path = "/".join(desktop_hash[i:i+2] for i in range(0,len(desktop_hash),2))
    return desktop_hash_path


if __name__ == "__main__":
    print get_desktop_hash_path("will", "default")