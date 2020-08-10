package com.icos.icosbus.sdk.server.schedule;

import com.icos.icosbus.annotation.QueueCallback;
import com.icos.icosbus.annotation.QueueCallbackType;
import com.icos.icosbus.annotation.RequestMapping;
import com.icos.icosbus.annotation.RequestMethod;
import com.icos.icosbus.reactive.Callback;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RequestMapping("/v1")
public class ScheduleEndpoint {
    private final static Logger logger = LoggerFactory.getLogger(ScheduleEndpoint.class);

    public ScheduleEndpoint() {
    }

    @QueueCallback({QueueCallbackType.INIT})
    public void init() {
        logger.debug(ScheduleEndpoint.class.getName() + " init ......");
    }


    @RequestMapping(value = "/hi", method = RequestMethod.GET)
    public void doHello(final Callback<String> callback) {
        callback.accept("ok");
    }


    @QueueCallback({QueueCallbackType.SHUTDOWN})
    public void shutdown() {
        logger.debug(ScheduleEndpoint.class.getName() + " shoutdown ......");
    }
}