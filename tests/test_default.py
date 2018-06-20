import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    '.molecule/ansible_inventory').get_hosts('all')


def test_nginx_running_and_enabled(host):
    nginx = host.service("nginx")
    assert nginx.is_running
    assert nginx.is_enabled


# Requires netstat or ss to be installed in the container, so doesn't work.
# def test_nginx_socket_listening(host):
#     assert host.socket("tcp://80").is_listening
