#!/bin/bash
tar -czvf ~/rpmbuild/SOURCES/helloworld-1.0.tar.gz helloworld-1.0
rpmbuild -ba helloworld-1.0/helloworld.spec
