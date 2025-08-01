import { AnimatedNumber, Button, LabeledList, NumberInput, Section } from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ThermoMachine = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={300} height={225}>
      <Window.Content>
        <Section title="Status">
          <LabeledList>
            <LabeledList.Item label="Temperature">
              <AnimatedNumber value={data.temperature} format={(value) => toFixed(value, 2)} />
              {' K'}
            </LabeledList.Item>
            <LabeledList.Item label="Pressure">
              <AnimatedNumber value={data.pressure} format={(value) => toFixed(value, 2)} />
              {' kPa'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Controls"
          buttons={
            <Button
              icon={data.on ? 'power-off' : 'times'}
              content={data.on ? 'On' : 'Off'}
              selected={data.on}
              onClick={() => act('power')}
            />
          }
        >
          <LabeledList>
            <LabeledList.Item label="Setting" textAlign="center">
              <Button
                fluid
                icon={data.cooling ? 'temperature-low' : 'temperature-high'}
                content={data.cooling ? 'Cooling' : 'Heating'}
                selected={data.cooling}
                onClick={() => act('cooling')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Target Temperature">
              <Button
                icon="fast-backward"
                disabled={data.target === data.min}
                title="Minimum temperature"
                onClick={() =>
                  act('target', {
                    target: data.min,
                  })
                }
              />
              <NumberInput
                animated
                value={Math.round(data.target)}
                unit="K"
                width={5.4}
                lineHeight={1.4}
                minValue={Math.round(data.min)}
                maxValue={Math.round(data.max)}
                step={5}
                stepPixelSize={3}
                onChange={(value) =>
                  act('target', {
                    target: value,
                  })
                }
              />
              <Button
                icon="fast-forward"
                disabled={data.target === data.max}
                title="Maximum Temperature"
                onClick={() =>
                  act('target', {
                    target: data.max,
                  })
                }
              />
              <Button
                icon="sync"
                disabled={data.target === data.initial}
                title="Room Temperature"
                onClick={() =>
                  act('target', {
                    target: data.initial,
                  })
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
