FROM swift:4.2

# Fetch
ARG SL="SwiftLint"
ARG URL="https://github.com/realm/${SL}.git"
ARG BRANCH="master"
RUN git clone --single-branch -b ${BRANCH} ${URL}
WORKDIR ${SL}
RUN git submodule update --init --recursive

# Build
ARG SL_BUILD_COMMAND="swift build --configuration release --static-swift-stdlib"
RUN ${SL_BUILD_COMMAND}
RUN mv `${SL_BUILD_COMMAND} --show-bin-path`/swiftlint /usr/bin

# Clean
WORKDIR /
RUN rm -rf ${SL}

# Verify
RUN swiftlint version

CMD ["swiftlint", "lint"]
