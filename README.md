# Hadoop test
Lightweight docker image with Apache Hadoop for integration testing

*.gitlab-ci.yml example:*
```yaml
integration-test:
  stage: test
  services:
    - name: mgid/hadoop:latest
      alias: hadoop
  when: manual
  script:
    - curl -s 'http://hadoop:50070/webhdfs/v1/?user.name=root&op=GETFILESTATUS'
```